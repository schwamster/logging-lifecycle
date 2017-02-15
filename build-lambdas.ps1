$path = "$PWD"
Set-Location -Path "$PWD\lambdas\MoveLogsToS3"
dotnet restore
dotnet test test\MoveLogsToS3.Tests\project.json
Set-Location "src\MoveLogsToS3"
dotnet lambda package 
Set-Location -Path $path
Copy-Item -Path "$PWD\lambdas\MoveLogsToS3\src\MoveLogsToS3\bin\Release\netcoreapp1.0\MoveLogsToS3.zip" -Destination "$PWD\lambdas\MoveLogsToS3.zip"