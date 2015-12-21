Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "YTF"
s.summary = "YTF Baaaaaam !"
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "DigitalStreet"}

# 4 - Replace with your name and e-mail address
s.author = { "[DigitalStreet" => "[contact@digitalstreetagency.fr]" }

# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://www.facebook.com/Digital-Street-793286050746201/?fref=ts"

# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/Pelletan/YTF-iOS.git", :tag => "#{s.version}"}

# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"
s.dependency 'Alamofire', '~> 2.0'
s.dependency 'MBProgressHUD', '~> 0.9.0'
s.dependency  'SwiftyJSON'
s.dependency  'SwiftOverlays', '~> 1.0'
s.dependency  "XCDYouTubeKit", "~> 2.4.2"

# 8
s.source_files = "YTF/**/*.{swift}"

# 9
s.resources = "YTF/**/*.{png,jpeg,jpg,storyboard,xib}"
end