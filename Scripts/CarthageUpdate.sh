#rm -rf ~/Library/Caches/org.carthage.CarthageKit
carthage update --no-build
carthage build RxSwift --platform iOS
carthage build JASON --platform iOS
carthage build RxHttpClient --platform iOS
carthage build OHHTTPStubs --platform iOS
mkdir -p ./Dependencies/iOS
./Scripts/CopyFrameworks.sh
#cp -R ./Carthage/Build/iOS/*.framework ./Dependencies/iOS