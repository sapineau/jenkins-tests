pipeline {
    agent any 
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '7', artifactNumToKeepStr: '10', daysToKeepStr:'7', numToKeepStr:'10')
    }
    stages {
        stage('Build') { 
            steps {
                sh 'dotnet restore ./SampleDotNetProject/SampleDotNetProject.sln' 
                sh 'dotnet build ./SampleDotNetProject/SampleDotNetProject.sln --no-restore' 
            }
        }
        stage('Test') { 
            steps {
                // By security, remove previous TestResults (drf => directory, remove, force (no error if directory does not exists))
                sh 'rm -drf ./SampleDotNetProject/TestSampleDotNetProject/TestResults'
                sh 'dotnet test ./SampleDotNetProject/SampleDotNetProject.sln --no-build --no-restore --collect "XPlat Code Coverage" -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.IncludeTestAssembly=true'
            }
            post {
                always {
                    // Need to install plugin "Coverage"
                    recordCoverage(tools: [[parser: 'COBERTURA', pattern: '**/coverage.cobertura.xml']], sourceDirectories: [[path: './SampleDotNetProject/TestSampleDotNetProject/TestResults']])
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