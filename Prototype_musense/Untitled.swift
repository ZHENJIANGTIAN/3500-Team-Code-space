import SwiftUI
import CoreMotion
import WatchKit

enum ShakeBand { case gentle, moderate, vigorous
    var color: Color {
        switch self {
        case .gentle:   return .blue
        case .moderate: return .yellow
        case .vigorous: return .red
        }
    }
}

final class MotionClassifier: ObservableObject {
    private let manager = CMMotionManager()
    private let queue = OperationQueue()

    private let accelPeakThreshold: Double = 1.6
    private let windowSec: Double = 1.0
    private let refractorySec: Double = 0.25
    private let updateHz: Double = 50

    private let enterModerateHz: Double = 1.5
    private let exitModerateHz:  Double = 1.1
    private let enterVigorousHz: Double = 3.5
    private let exitVigorousHz:  Double = 3.0

    @Published var freqHz: Double = 0.0
    @Published var band: ShakeBand = .gentle

    private var peaks: [TimeInterval] = []
    private var lastPeak: TimeInterval = 0
    private var emaFreq: Double = 0.0
    private let alpha: Double = 0.35

    func start() {
        guard manager.isDeviceMotionAvailable else { return }
        manager.deviceMotionUpdateInterval = 1.0 / updateHz
        manager.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical, to: queue) { [weak self] motion, _ in
            guard let self, let m = motion else { return }
            let a = m.userAcceleration
            let mag = sqrt(a.x*a.x + a.y*a.y + a.z*a.z)
            let now = Date().timeIntervalSince1970

            if mag > self.accelPeakThreshold, (now - self.lastPeak) > self.refractorySec {
                self.lastPeak = now
                self.peaks.append(now)
            }
            let cutoff = now - self.windowSec
            while let f = self.peaks.first, f < cutoff { self.peaks.removeFirst() }

            let raw = Double(self.peaks.count) / self.windowSec
            self.emaFreq = self.alpha * raw + (1 - self.alpha) * self.emaFreq

            let nextBand: ShakeBand
            switch self.band {
            case .gentle:
                nextBand = (self.emaFreq >= self.enterModerateHz)
                    ? ((self.emaFreq >= self.enterVigorousHz) ? .vigorous : .moderate)
                    : .gentle
            case .moderate:
                if self.emaFreq >= self.enterVigorousHz { nextBand = .vigorous }
                else if self.emaFreq < self.exitModerateHz { nextBand = .gentle }
                else { nextBand = .moderate }
            case .vigorous:
                nextBand = (self.emaFreq < self.exitVigorousHz) ? .moderate : .vigorous
            }

            DispatchQueue.main.async {
                self.freqHz = self.emaFreq
                self.band   = nextBand
            }
        }
    }

    func stop() {
        manager.stopDeviceMotionUpdates()
        DispatchQueue.main.async {
            self.freqHz = 0; self.band = .gentle; self.emaFreq = 0
            self.peaks.removeAll(); self.lastPeak = 0
        }
    }
}

struct IntroView: View {
    @Binding var isActive: Bool
    var body: some View {
        VStack(spacing: 12) {
            Text("Shake your hands to the beat!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
            Button("Start") { isActive = true }
                .font(.body.weight(.semibold))
        }
        .padding(.horizontal, 10)
    }
}

struct ActiveView: View {
    @ObservedObject var motion: MotionClassifier
    @Binding var isActive: Bool

    var body: some View {
        ZStack {
            motion.band.color.ignoresSafeArea()
            VStack(spacing: 4) {
                Text(String(format: "", motion.freqHz))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text("").font(.caption).opacity(0.85)
            }
        }
        .onAppear { motion.start(); WKInterfaceDevice.current().play(.start) }
        .onDisappear { motion.stop() }
    }
}

struct SecondPageView: View {
    @StateObject private var motion = MotionClassifier()
    @State private var isActive = false
    var body: some View {
        Group { isActive ? AnyView(ActiveView(motion: motion, isActive: $isActive))
                         : AnyView(IntroView(isActive: $isActive)) }
    }
}

#Preview { SecondPageView() }

