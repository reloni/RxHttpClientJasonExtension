#rm -rf ~/Library/Caches/org.carthage.CarthageKit
carthage checkout --use-submodules
carthage build RxSwift --platform iOS
carthage build JASON --platform iOS
carthage build RxHttpClient --platform iOS
mkdir -p ./Dependencies/iOS
cp -R ./Carthage/Build/iOS/*.framework ./Dependencies/iOS