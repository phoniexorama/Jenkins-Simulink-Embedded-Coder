pipeline {

    agent {
      label 'windows-agent' // Label for the Windows agent node  
    }

    environment {
    GEN_CODE_ONLY = 'off'
    }
    stages {

        stage('Copy Folder') {
            steps {
                script {
                    // Check the operating system
                    def isWindows = isUnix() ? false : true

                    // Source and destination paths
                    def sourcePath = isWindows ? 'C:\\JenkinsAgent\\workspace\\Keerthi\\RunMatlab' : '/path/to/source_folder'
                    def destinationPath = isWindows ? 'C:\\Users\\KSREERANG' : '/path/to/destination_folder'

                    // Copy the folder
                    if (isWindows) {
                        bat "xcopy \"${sourcePath}\" \"${destinationPath}\" /E /I /H /K"
                    } else {
                        sh "cp -r ${sourcePath} ${destinationPath}"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                runMATLABCommand 'run(\'arduino_build\')'
            }
        }

        stage('Artifact Management') {
            parallel {
                stage('Archive Binaries') {
                    steps {
                        archiveArtifacts(caseSensitive: true, fingerprint: true, artifacts: '*.elf, *.hex', allowEmptyArchive: true)
                    }
                }

                stage('Archive Build Source') {
                    steps {
                        archiveArtifacts '*_ert_rtw/**/*'
                    }
                }
            }
        }
    }
}
