#!Groovy

/**
(c) Copyright 2023 Vikas Pachisia.

report issues at: https://github.com/vikaspachisia/devops-examples/issues


Licensed under the MIT license:

    http://www.opensource.org/licenses/mit-license.php

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

**/

/**

The Jenkinsfile provides an example to primarily descibe how to build code 
for multiple architectures, configurations and platforms.
This information was not easily available on internet.

This example code will not demonstrate running jobs on different platforms.
It is to provide a design example to compile code for various configurations on any given single node.
For example if a c++ code is being compiled for linux then think of it as cross compilation task 
instead of compiling on a linux box.

**/

import net.jenkinsci.tools.*

/* 
Define the list of build options supported by your project. 
The options defined below are most commonly used options 
to build binaries on Windows platform but is also supported by other platforms such as Linux.
*/

/*
Define the list of modules that can be run as part of unit tests.
*/
Map unit_test_modules = [
UT_MODULE_1: [LABEL: 'Test Module 1', BIN_RELATIVE_PATH: 'Module1.dll', LOGFILE_RELATIVE_PATH: 'Module1.trx'],
UT_MODULE_1: [LABEL: 'Test Module 2', BIN_RELATIVE_PATH: 'UT\\Module2.dll', LOGFILE_RELATIVE_PATH: 'Module2.trx'],
]

Map build_parameter_options = [
CONFIGURATION: ['Release', 'Debug'],
PLATFORM: ['x86','x64','ARM','ARM64'],
OS: ['WIN10', 'WIN10S', 'LINUX']
]

Map platform_parameters = [
WIN10: [BUILD_TARGET: 'build', ARCHIVE_FOLDER: 'Win10'],
WIN10S: [BUILD_TARGET: 'rebuild', ARCHIVE_FOLDER: 'Win10S'],
LINUX: [BUILD_TARGET: 'build', ARCHIVE_FOLDER: 'Linux']
]

/*
Build a matrix of build configurations by combining the build parameters while excluding certain combinations explicitly.
*/
List build_parameter_sets = getMatrixAxes(build_parameter_options, user_prompt: isBuilding('manually')) { Map axis ->
  !(axis['OS'] == 'WIN10S') &&
  !(axis['PLATFORM'] == 'ARM'))
}

def current_product_version = "0.0.0"
def updated_product_version = "0.0.0"
def project_name = "devops-examples"

pipeline {
  agent { label 'SOME_BUILD_NODE' }
  triggers {
    //Assuming we follow at least the basic scm workflow model wherein 'develop' branch is the main development and integration branch.
    //Also assuming the daily build will run on jobs having 'daily' in their name.
    cron( env.JOB_BASE_NAME.contains('Daily') && env.BRANCH_NAME.equals('develop') ? 'H 12,17 * * 1-4' : '')
  }

  options {
    skipStagesAfterUnstable()
    retry(1)
    copyArtifactPermission('*')
  }

  parameters {
    choice(name:'SOURCE_ENVIRONMENT_TYPE', choices:['DEVOPS','DEV'], description: 'Build artifacts as part of CI/CD (Devops) or as a developer does on his local machine.')
    choice(name: 'TARGET_ENVIRONMENT_TYPE', choices:['QA','STAGE','PRODUCTION'], description:'Build artifacts for a suitable target environment accroding to program strategy or process.')
    booleanParam(name: 'UPLOAD_ARTIFACTS', defaultValue: false, description: 'Upload the artificats to artifact reposiotories. Select only for important builds.')
    booleanParam(name: 'NOTIFY_BUILD_RESULT', defaultValue: true, description: 'Send email notifications for builds. Unset while testing and experimenting.')
    booleanParam(name: 'RUN_UNIT_TESTS', defaultValue: false, description: 'Unit test runs are good thing but might be skipped sometimes such as in urgent build creations. ')
  }

  environment {
    BUILD_NODE_CREDENTIAL = credentials('1111111111111111111111111111111111111111111')
    GITHUB_SCM_CREDENTIALS = credentials('111111111111111111111111111111111111111111')
    BUILD_SUPPORT_TOOLS = "c:\\build-support-tools"

    //Not a good way to use visual studio but defining here for novices and extreme conditions.
    MSBUILD_TOOL = 'tool name: \'17\', type: \'msbuild\''
    VS_ROOT="C:\\Program Files (x86)\\Microsoft Visual Studio\\2022\\Enterprise\\Common7"
    VS_TOOLS="${VS_ROOT}\\Tools"
    VS_IDE="${VS_ROOT}\\IDE"
    VS_MSBUILDCMD="${VS_TOOLS}\\VsMSBuildCmd.bat"
    VS_DEVCMD="${VS_TOOLS}\\VSDevCmd.bat"

    ARCHIVES_DIR = "${env.WORKSPACE}\\Outputs\\Archives"
    ARTIFACTS_DIR = "${env.WORKSPACE}\\Outputs\\Artifacts"
    BIN_DIR = "${env.WORKSPACE}\\Outputs\\Bin"
    REPORTS_DIR = "${env.WORKSPACE}\\Reports"
    SOURCE_DIR = "${env.WORKSPACE}\\Source"
    TOOLS_DIR = "${env.WORKSPACE}\\Tools"
    TEMP_DIR = "${env.WORKSPACE}\\Temp"
    TESTS_DIR = "${env.WORKSPACE}\\Tests"
    
    LOGS_DIR = "${TEMP_DIR}\\Logs"
    
    SCRIPTS_DIR = "${env.WORKSPACE}\\Scripts"
    POWERSHELL_SCRIPTS_DIR = "${SCRIPTS_DIR}\\PowershellScripts"
    PYTHON_SCRIPTS_DIR = "${SCRIPTS_DIR}\\PythonScripts"
    PERL_SCRIPTS_DIR = "${SCRIPTS_DIR}\\PerlScripts"
    BATCH_SCRIPTS_DIR = "${SCRIPTS_DIR}\\BatchScripts"

    SOLUTION_FILEPATH = "${SOURCE_DIR}\\devops-examples.sln"
    
    QA_COVERAGEANALYSISFILENAME = "${VS_IDE}\\PrivateAssemblies\\Microsoft.VisualStudio.Coverage.Analysis.dll"
    QA_COVERAGEOUTFILEEXTENSION = ".coveragexml"

    EMAIL_TO_LIST = "firstname.lastname@domain.com"
    EMAIL_REPLYTO_LIST = "firstname.lastname@domain.com"
	
  }

  stages {
    stage('Code-To-Artifacts') {
      stages {
        stage('Pre-Build') {
          stages {
            stage('Update-Dependencies') {
              steps {
                echo "Updating dependencies for ${SOLUTION_FILEPATH}..."

                //Install and put nuget into path if you want to use nuget.exe
                //bat label: 'Nuget Restore', script: 'nuget restore \"${SOLUTION_FILEPATH}\"'

                bat label: 'Dotnet Restore', script: "dotnet restore \"${SOLUTION_FILEPATH}\""
                bat label: 'MSBuild Restore', script: "\"${VS_DEVCMD}\" && msbuild \"${SOLUTION_FILEPATH}\" -t:restore -p:RestoreLockedMode=true"

                echo "Updated dependencies for ${SOLUTION_FILEPATH}..."
              }
            }
            stage('Get-Current-Version') {
              steps{
                script {
                  echo "Getting version for projects in ${SOLUTION_FILEPATH}..."

                  current_product_version = powershell(label: 'Get Product Version', returnStdout:true, script: ". '${POWERSHELL_SCRIPTS_DIR}\\GetVersion.ps1' -SourceDirectory '${SOURCE_DIR}' -VersionType 'product'").trim()
                  echo 'current product version:${current_product_version}'

                  echo "Got version for projects in ${SOLUTION_FILEPATH}."
                }
              }
            }
            stage('Update-Version') {
              steps{
                script {
                  echo "Updating version for projects in ${SOLUTION_FILEPATH}..."

                  //Assuming a powershell script is available to update the product version which takes parameters such as source code base, version change data etc. 
                  //One design concept that can work here is to provide the change in each version part.
                  //The change is ideally incremental and hence monotonically increasing or in rare case it can be decreasing for example when building an old version.
                  //Either of this change can be signaled via natuaral operations '+' and '-' with '0' representing no change.
                  //Another design concept is to change the actual product version as part of code change and update only build and meta information changes as part of CI/CD.
                  updated_product_version = powershell(label: 'Update Product Version', returnStdout:true, script: ". '${POWERSHELL_SCRIPTS_DIR}\\UpdateVersion.ps1' -SourceDirectory '${SOURCE_DIR}' -VersionType 'product' -VersionChange '0.0.0.${currentBuild.number}'").trim()
                  echo 'Updated product version:${updated_product_version}'

                  echo "Updated version for projects in ${SOLUTION_FILEPATH}."
                }
              }
            }
            stage('Update-Environments'){
              steps{
                script{
                  echo 'Updating source environment type as ${params.SOURCE_ENVIRONMENT_TYPE}...'
                  
                  env_updated = powershell(label: 'Update Source Environment Type', returnStdout:true, script: ". '${POWERSHELL_SCRIPTS_DIR}\\UpdateEnvironment.ps1' -SourceDirectory '${SOURCE_DIR}' -SourceEnvironmentType '${params.SOURCE_ENVIRONMENT_TYPE}'").trim()
                  
                  echo 'Updated source environment type as ${params.SOURCE_ENVIRONMENT_TYPE}.'
                }
                script{
                  echo 'Updating target environment type as ${params.TARGET_ENVIRONMENT_TYPE}...'
                  
                  env_updated = powershell(label: 'Update Target Environment Type', returnStdout:true, script: ". '${POWERSHELL_SCRIPTS_DIR}\\UpdateEnvironment.ps1' -SourceDirectory '${SOURCE_DIR}' -TargetEnvironmentType '${params.TARGET_ENVIRONMENT_TYPE}'").trim()
                  
                  echo 'Updated target environment type as ${params.TARGET_ENVIRONMENT_TYPE}.'
                }
              }
            }
          }
        }

        stage('Build-Test'){
          steps {
            script {
              build_parameter_sets.each { build_parameter_set ->                
                def buildTargetConfiguration = build_parameter_set.CONFIGURATION
                def buildTargetPlatform = build_parameter_set.PLATFORM
                def buildTargetOS = build_parameter_set.OS

                def buildTargetSerializedText = "${buildTargetOS}-${buildTargetConfiguration}-${buildTargetPlatform}"
                def buildTargetRelativePath = "${buildTargetOS}\\${buildTargetConfiguration}\\${buildTargetPlatform}"
                
                def buildTargetOSData = platform_parameters["${buildTargetPlatform.toUpperCase()}"]

                stage ("Build-${buildTargetSerializedText}") {
                  echo "Building ${buildTargetSerializedText}..."

                  bat label: 'Build Product', script: "\"${VS_DEVCMD}\" && msbuild \"${SOLUTION_FILEPATH}\" -t:\"${buildTargetOSData.BUILD_TARGET}\" /p:Configuration=\"${buildTargetConfiguration}\" /p:Platform=\"${buildTargetPlatform}\""
                  
                  echo "Built ${buildTargetSerializedText}."
                }

                stage ("Test-${buildTargetSerializedText}") {
                  if(params.RUN_UNIT_TESTS) {
                    echo "Testing ${buildTargetSerializedText}..."

                    //Since unit tests were not supported on ARM platforms. Check MSDN (MS Learn) for latest upates.
                    if("${buildTargetPlatform}" == "x86" || "${buildTargetPlatform}" == "x64") {
                      def testModules = ""
                      def testModuleLabels = ""
                      def testResultsDir = "${REPORTS_DIR}\\${buildTargetRelativePath}"
                      def testResultsFilename = "TestResults.trx"

                      unit_test_modules.each { test_module_key, test_module_value ->
                        testModuleLabels += " ${test_module_value.LABEL}"
                        testModules += " \"${TESTS_DIR}\\${buildTargetRelativePath}\\${test_module_value.BIN_RELATIVE_PATH}\""
                      }

                      try {
                        echo "Testing ${testModuleLabels}..."
                        bat label: "Unit Testing Modules", script: "\"${VS_DEVCMD}\" && vstest.console.exe /Enablecodecoverage /Platform:${buildTargetPlatform} /ResultsDirectory:\"${testResultsDir}\" /logger:trx;LogFileName=\"${testResultsFilename}\" ${testModules}"
                        echo "Tested ${testModuleLabels}."
                      }
                      catch(ex){
                        errMsg = ex.getMessage()
                        echo "Test failed: ${testModuleLabels} because ${errMsg}"
                      }
                    }
                    echo "Tested ${buildTargetSerializedText}."
                  }
                  else
                  {
                    echo "Test skipped: ${buildTargetSerializedText}."
                  }
                }
              }
            }
          }
        }

        stage('Sign-Archive'){
          steps {
            script {
              build_parameter_sets.each { build_parameter_set ->
                def buildTargetConfiguration = build_parameter_set.CONFIGURATION
                def buildTargetPlatform = build_parameter_set.PLATFORM
                def buildTargetOS = build_parameter_set.OS

                def buildTargetSerializedText = "${buildTargetOS}-${buildTargetConfiguration}-${buildTargetPlatform}"
                def buildTargetRelativePath = "${buildTargetOS}\\${buildTargetConfiguration}\\${buildTargetPlatform}"
                
                def buildTargetOSData = platform_parameters["${buildTargetPlatform.toUpperCase()}"]
				        
                stage("SignBinaries-${buildTargetSerializedText}"){
				          echo "Signing binaries for ${buildTargetSerializedText}..."
                  //Will hopefully look for properties/settings file recursively. (e.g. Directory.Binaries.Settings)
				          def result = powershell(returnStdout: true, script: "${POWERSHELL_SCRIPTS_DIR}\\SignBinaries.ps1 -InputDirectory '${BIN_DIR}' -OutputDirectory '${BIN_DIR}' -BuildTargetOS '${buildTargetOS}' -BuildTargetConfiguration '${buildTargetConfiguration}' -BuildTargetPlatform '${buildTargetPlatform}' -SourceEnvironmentType '${params.SOURCE_ENVIRONMENT_TYPE}' -TargetEnvironmentType '${params.TARGET_ENVIRONMENT_TYPE}'")
                  echo "Signed binaries for ${buildTargetSerializedText}."
				        }

                stage("CreateArtifacts-${buildTargetSerializedText}"){
				          echo "Create artifacts for ${buildTargetSerializedText}..."
                  //Will hopefully look for properties/settings file recursively. (e.g. Directory.Artifacts.Settings)
				          def result = powershell(returnStdout: true, script: "${POWERSHELL_SCRIPTS_DIR}\\CreateArtifacts.ps1 -InputDirectory '${BIN_DIR}' -OutputDirectory '${ARTIFACTS_DIR}' -BuildTargetOS '${buildTargetOS}' -BuildTargetConfiguration '${buildTargetConfiguration}' -BuildTargetPlatform '${buildTargetPlatform}' -SourceEnvironmentType '${params.SOURCE_ENVIRONMENT_TYPE}' -TargetEnvironmentType '${params.TARGET_ENVIRONMENT_TYPE}'")
                  echo "Create artifacts for ${buildTargetSerializedText}."
				        }

                stage("SignArtifacts-${buildTargetSerializedText}"){
				          echo "Sign artifacts for ${buildTargetSerializedText}..."
                  //Will hopefully look for properties/settings file recursively. (e.g. Directory.Artifacts.Settings)
				          def result = powershell(returnStdout: true, script: "${POWERSHELL_SCRIPTS_DIR}\\SignArtifacts.ps1 -InputDirectory '${ARTIFACTS_DIR}' -OutputDirectory '${ARTIFACTS_DIR}' -BuildTargetOS '${buildTargetOS}' -BuildTargetConfiguration '${buildTargetConfiguration}' -BuildTargetPlatform '${buildTargetPlatform}' -SourceEnvironmentType '${params.SOURCE_ENVIRONMENT_TYPE}' -TargetEnvironmentType '${params.TARGET_ENVIRONMENT_TYPE}'")
                  echo "Sign artifacts for ${buildTargetSerializedText}."
				        }

                stage ("ArchiveArtifacts-${buildTargetSerializedText}") {
                  echo "Archiving artifacts for ${buildTargetSerializedText}..."

                  //Will hopefully look for properties/settings file recursively. (e.g. Directory.Artifacts.Settings)
                  powershell label: 'Archive Artifacts', script: ". '${POWERSHELL_SCRIPTS_DIR}\\ArchiveArtifacts.ps1' -InputDirectory '${ARTIFACTS_DIR}' -OutputDirectory '${ARCHIVES_DIR}' -BuildTargetOS '${buildTargetOS}' -BuildTargetConfiguration '${buildTargetConfiguration}' -BuildTargetPlatform '${buildTargetPlatform}' -SourceEnvironmentType '${params.SOURCE_ENVIRONMENT_TYPE}' -TargetEnvironmentType '${params.TARGET_ENVIRONMENT_TYPE}'"
                  
                  //Archive in Jenkins
                  archiveArtifacts caseSensitive:false, allowEmptyArchive:true, fingerprint:true, artifacts: "${ARTIFACTS_DIR}/*.zip, ${ARTIFACTS_DIR}/*.7z"

                }

                  echo "Archived artifacts for ${buildTargetSerializedText}."
                }
				}
			}
		}
	}


        stage('Post Build'){
          stages{
            stage('Upload-Artifacts') {
              when { expression { return params.UPLOAD_ARTIFACTS } }
              steps{
                echo "Uploading artifacts from ${ARCHIVES_DIR}..."
                //Archive in Artifactory
                 
                 rtUpload (
                  serverId: "Artifactory-${params.TARGET_ENVIRONMENT_TYPE}",
                  spec: '''{
                    "files": [
                      {
                        "pattern": "${ARCHIVES_DIR}/*.zip",
                        "target": "${project_name}/${updated_product_version}"
                      }
                    ]
                  }''',

                  // Optional - Associate the uploaded files with the following custom build name and build number,
                  // as build artifacts.
                  // If not set, the files will be associated with the default build name and build number (i.e the 
                  // the Jenkins job name and number).
                  buildName: "${env.JOB_NAME}",
                  buildNumber: "${env.BUILD_NUMBER}",
                  // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                  project: "${project_name}"
                )
                                
                echo "Uploaded artifacts from ${DRIVER_DIST_DIR}..."
              }
            }
            stage('Publish Results'){
              steps {
                script {
                  echo "Publishing test reports..."

                  try{
                      powershell label: 'Convert Coverage Results', script: ". '${POWERSHELL_SCRIPTS_DIR}\\CoverageConverter' '${REPORTS_DIR}' '${QA_COVERAGEOUTFILEEXTENSION}' '${QA_COVERAGEANALYSISFILENAME}'"
                    }
                    catch(ex){
                      echo "[FAILED][Convert Coverage Results]. currentBuild.result=${currentBuild.result}, currentBuild.currentResult=${currentBuild.currentResult}"
                      echo "[Reason]: " + ex.toString()
                    }

                    try {
                        step([$class: 'MSTestPublisher', testResultsFile:"**/*.trx", failOnError: true, keepLongStdio: true])
                      } catch(ex){
                        echo "[FAILED][MSTestPublisher] currentBuild.result=${currentBuild.result}, currentBuild.currentResult=${currentBuild.currentResult}"
                        echo "[Reason]:" + ex.toString()
                      }

                      try {
                        publishCoverage adapters: [jacocoAdapter('**/emma/coverage.xml')], sourceFileResolver: sourceFiles('NEVER_STORE')
                        //publishCoverage adapters: [jacocoAdapter(mergeToOneReport: true, path: '**/emma/coverage.xml')]
                        } catch(ex){
                          echo "[FAILED][PublishCoverage][JacocoAdapter] currentBuild.result=${currentBuild.result}, currentBuild.currentResult=${currentBuild.currentResult}"
                          echo "[Reason]:" + ex.toString()
                        }

                        echo "[Build Result][Actual]: currentBuild.result=${currentBuild.result}, currentBuild.currentResult=${currentBuild.currentResult}"
                        echo "Published test reports."
                    }
                  }
                }
                stage('Notify Results'){
                  when { expression { return params.NOTIFY_BUILD_RESULT } }
                  steps{
                    script {
                      echo "Notifying builds..."

                      def resultfileAntPattern = "**".replace("\\","/")

                      emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                      mimeType: 'text/html',
                      subject: "[Jenkins] ${currentBuild.fullDisplayName}[${currentBuild.number}] - ${currentBuild.currentResult}",
                      attachmentsPattern: "${resultfileAntPattern}/*.trx,${resultfileAntPattern}/*.coverage,${resultfileAntPattern}/*${QA_COVERAGEOUTFILEEXTENSION}",
                      to: "${EMAIL_TO_LIST}",
                      replyTo: "${EMAIL_REPLYTO_LIST}",
                      recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]

                      echo "Notified builds."
                    }
                  }
                }
              }
            }
          }
        }
      }
      post {
        always {
          echo 'Success or failure we have finished!'
          script {
            echo "Invoke smoke test..."

            powershell label: 'Run smoke tests', script: ". '${POWERSHELL_SCRIPTS_DIR}\\TriggerSmokeTest'"

            echo "Invoked smoke test."
          }
        }
        success{
          echo 'Actually it is a success!'
        }
        fixed {
          echo 'Someone fixed me :)'
        }
        regression {
          echo 'Someone broke me :('
        }
        unstable {
          echo 'I am unstable :/'
        }
        failure {
          echo 'Actually it is a failure!'
        }
        changed {
          echo 'Things were different before...'
        }
      }
    }
