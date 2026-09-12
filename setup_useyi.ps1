$ErrorActionPreference = "Stop"

Write-Host "Checking Flutter..."
flutter --version

Write-Host "Creating Android/iOS platform folders..."
flutter create --platforms=android,ios .

Write-Host "Installing packages..."
flutter pub get

Write-Host ""
Write-Host "USEYI Monitor setup complete."
Write-Host "Run on Android with: flutter run"
Write-Host "For iOS, open ios/Runner.xcworkspace on a Mac with Xcode."
