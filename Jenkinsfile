pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'dotnet restore ./SampleDotNetProject/SampleDotNetProject.sln' 
                sh 'dotnet build ./SampleDotNetProject/SampleDotNetProject.sln --no-restore' 
            }
        }
    }
}