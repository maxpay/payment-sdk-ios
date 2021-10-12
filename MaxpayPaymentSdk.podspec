Pod::Spec.new do |spec|
  spec.name                  = "MaxpayPaymentSdk"

  spec.version               = "1.1.1"

  spec.summary               = "Accept online payments using Maxpay."
  spec.description           = <<-DESC
  The Maxpay Payment iOS SDK makes it quick and easy to build a payment screen in your iOS app.
              DESC
  spec.homepage              = "https://maxpay.com/docs/"
  spec.license               = { :type => 'MIT', :file => 'LICENSE' }
  spec.author                = { "Maxpay" => "support@maxpay.com" }
  spec.source                = { :git => "https://github.com/maxpay/payment-sdk-ios.git", :tag => "#{spec.version}" }
  spec.frameworks            = 'Foundation', 'WebKit', 'UIKit'
  spec.ios.deployment_target = '13.0'
  spec.swift_version		     = '5.0'
  spec.source_files          = "MaxpayPaymentSdk/**/*.swift"
  spec.resource_bundle       = { 'Maxpay' => 'MaxpayPaymentSdk/**/*.{lproj,json,png,xcassets}' }
  spec.resources             = "MaxpayPaymentSdk/**/*.xib"

end
