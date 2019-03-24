import Dispatch
import Foundation


enum TimerError: Error {
    case timerRunningError(String)
}


public class Timer {
    private var start: DispatchTime
    private var end = DispatchTime(uptimeNanoseconds: 0)

    public init () {
        start = DispatchTime.now()
    }

    public func stop(){
        end = DispatchTime.now()
    }

    public func getTime() -> UInt64 {
//TODO
//        guard end.uptimeNanoseconds > 0 else {
//            throw TimerError.timerRunningError("Timer.stop() must be called first")
//        }
        return end.uptimeNanoseconds - start.uptimeNanoseconds
    }

    public func getTimeAsString() -> String {
        return getTimeString (Double(end.uptimeNanoseconds - start.uptimeNanoseconds) )
    }
}


func getExecutionTime(_ function: () -> ()) -> Double {
    let timer = Timer()
    function()
    timer.stop()
    return Double(timer.getTime())
}


func getTimeString(_ nanoseconds: Double) -> String {
    if nanoseconds < 1e3 {
        return "\(nanoseconds) ns"
    } else if nanoseconds < 1e6 {
        return "\(nanoseconds/1e3) µs"
    } else if nanoseconds < 1e9 {
        return "\(nanoseconds/1e6) ms"
    } else {
        return "\(nanoseconds/1e9) seconds"
    }
}


public func timeMagic(_ function: () -> ()) {
    let nanoseconds = getExecutionTime(function)
    print("\(getTimeString(nanoseconds))")
}


public func timeitMagic(_ n_times: Int = 10, _ function: () -> ()) {
    assert(n_times > 0)
    let nsArray: [Double] = (0..<n_times+1).map({_ in getExecutionTime(function)})
    print("Max: \(getTimeString(nsArray.max()!))")
    print("Min: \(getTimeString(nsArray.min()!))")
    let mean = (nsArray.reduce(0, +)) / Double(n_times)
    print("Mean: \(getTimeString(mean))")
    let variance = nsArray.map({pow(($0 - mean), 2)}).reduce(0, +) / Double(n_times)
    print("Std Dev: \( getTimeString(sqrt(variance)))")
}
