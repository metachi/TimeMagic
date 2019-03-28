import Dispatch
import Foundation


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
        if end.uptimeNanoseconds == 0 {
            print("Warning Timer.stop() never called")
	}
        return end.uptimeNanoseconds - start.uptimeNanoseconds
    }

    public func getTimeAsString() -> String {
        return getTimeString (Double(getTime()) )
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
    let nsArray: [Double] = (0..<n_times).map({_ in getExecutionTime(function)})
    let mean = (nsArray.reduce(0, +)) / Double(n_times)
    let variance = nsArray.map({pow(($0 - mean), 2)}).reduce(0, +) / Double(n_times)

    print("Max: \(getTimeString(nsArray.max()!))")
    print("Min: \(getTimeString(nsArray.min()!))")
    print("Mean: \(getTimeString(mean))")
    print("Std Dev: \( getTimeString(sqrt(variance)))")
}
