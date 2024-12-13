//
//  AppExtension.swift
//  FastExtension
//
//  Created by pan zhang on 2022/6/29.
//

extension UIApplication:FastExtensionCompatible {}
extension FastExtensionWrapper where Base: UIApplication {
    public var isRuningBackgroud: Bool {
        let state = base.applicationState
        return state == .background
    }
    
    public static var bundleIdentifier:String {
        return Bundle.main.bundleIdentifier ?? "null"
    }
    
    /// 跳转到手机设置页面
    public static func toAppSetting() -> Bool{
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
            return true
        }
        return false
    }
    
    /// 跳转到App Store的评论页面
    /// - Parameter appID: appid
    public static func toAppReviewPageOf(appID: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { success in
                    if success {
                        print("Successfully opened App Store review page.")
                    } else {
                        print("Failed to open App Store review page.")
                    }
                }
            } else {
                print("Cannot open App Store review page.")
            }
        }
    }
    
    /// 当前ip地址（静态ip，不是公网IP）
    public static var ipAddress: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        
        return addresses.first ?? "0.0.0.0"
    }
}

