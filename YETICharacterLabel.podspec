Pod::Spec.new do |spec|
  spec.name = 'YETICharacterLabel'
  spec.version = '1.0.1'
  spec.authors = {'Andrew Hulsizer' => 'andrew.hulsizer@gmail.com'}
  spec.homepage = 'https://github.com/android1989/YetiCharacterLabelExample'
  spec.summary = 'UILabel subclass that renders each glyph on its own CATextLayer, allowing for advanced text effects.'
  spec.source = {:git => 'https://github.com/android1989/YetiCharacterLabelExample.git', :tag => "v#{spec.version}"}
  spec.source_files = 'YETICharacterLabel/*/*.{h,m}'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.platform = :ios, '7.0'
  spec.requires_arc = true
  spec.frameworks = 'Foundation','CoreText','QuartzCore'
  spec.social_media_url = 'https://twitter.com/swiftyeti'

end
