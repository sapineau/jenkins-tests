pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'dotnet restore ./SampleDotNetProject/SampleDotNetProject.sln' 
                sh 'dotnet build ./SampleDotNetProject/SampleDotNetProject.sln --no-restore' 
            }
        }
        stage('Test') { 
            steps {
                sh 'dotnet test ./SampleDotNetProject/SampleDotNetProject.sln --no-build --no-restore --collect "XPlat Code Coverage"'
            }
            post {
                always {
                    recordCoverage(tools: [[parser: 'COBERTURA', pattern: '**/*.xml']], sourceDirectories: [[path: './SampleDotNetProject/TestSampleDotNetProject/TestResults']])
                }
            }
        }
        stage('Deliver') { 
            steps {
                sh 'dotnet publish ./SampleDotNetProject/SampleDotNetProject.sln --no-restore -o published' 
            }
            post {
                success {
                    archiveArtifacts 'published/*.*'
                }
            }
        }
    }
}