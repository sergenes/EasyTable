Pod::Spec.new do |s|
s.name = 'EasyTable'
s.version = '1.0'
s.license = 'Apache-2.0'
s.summary = 'Use static UITableView Made insanely simple'
s.homepage = 'https://github.com/sergenes/EasyTable'
s.authors = { 'Sergey Nes' => 'serge.nes@gmail.com' }
s.source = { :git => 'https://github.com/sergenes/EasyTable.git', :tag => s.version }

s.ios.deployment_target = '8.0'

s.source_files = 'EasyTable/*.swift'

s.requires_arc = true
end
