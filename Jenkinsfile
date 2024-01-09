pipeline {

    agent {
      label 'windows-agent' // Label for the Windows agent node  
    }

    environment {
        GEN_CODE_ONLY = 'off'
        MATLAB_COMMAND = 'C:\\Program Files\\MATLAB\\R2023b\\bin\\matlab.exe'
        MATLAB_SCRIPT_PATH = 'C:\\D_drive\\test_matlab\\test.m'
    }
    stages {

        /*stage('Copy Folder') {
            steps {
                script {
                    // Check the operating system
                    def isWindows = isUnix() ? false : true

                    // Source and destination paths
                    def sourcePath = isWindows ? 'C:\\JenkinsAgent\\workspace\\Keerthi\\RunMatlab' : '/path/to/source_folder'
                    def destinationPath = isWindows ? 'C:\\Users\\KSREERANG\\RunMatlab' : '/path/to/destination_folder'

                    // Copy the folder
                    if (isWindows) {
                        bat "xcopy \"${sourcePath}\" \"${destinationPath}\" /E /I /H /K"
                    } else {
                        sh "cp -r ${sourcePath} ${destinationPath}"
                    }
                }
            }
        }*/

        stage('Run MATLAB Script') {
            steps {
                script {
                    // Run on Windows
                    if (isUnix()) {
                        echo 'Running on Unix-based system'
                        sh "\"${MATLAB_COMMAND}\" -r \"cd ${MATLAB_SCRIPT_PATH};try, run ('${MATLAB_SCRIPT_PATH}'); end;\""
                    } else {
                        echo 'Running on Windows'
                        bat "\"${MATLAB_COMMAND}\" -r \"cd ${MATLAB_SCRIPT_PATH};try, run ('${MATLAB_SCRIPT_PATH}'); end;\""
                    }
                }
            }
        }

        stage('Build') {
            steps {
                runMATLABCommand 'run(C:\\Users\\KSREERANG\\RunMatlab\\arduino_build)'
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
