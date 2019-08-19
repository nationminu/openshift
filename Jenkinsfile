node('maven') {
  stage('Build') {
    git url: "https://github.com/nationminu/openshift.git"
    sh "pwd;ls"
    sh "cd cart-service;pwd ls"
    sh "cd cart-service;mvn package"
    stash name:"jar", includes:"target/cart.jar"
  }
  stage('Test') {
    parallel(
      "Cart Tests": {
        sh "cd cart-service;mvn verify -P cart-tests"
      },
      "Discount Tests": {
        sh "cd cart-service;mvn verify -P discount-tests"
      }
    )
  }
  stage('Build Image') {
//    unstash name:"cd cart-service;jar"
    sh "oc start-build cart --from-file=cart-service/target/cart.jar --follow"
  }
  stage('Deploy') {
    openshiftDeploy depCfg: 'cart'
    openshiftVerifyDeployment depCfg: 'cart', replicaCount: 1, verifyReplicaCount: true
  }
  stage('System Test') {
    sh "curl -s -X POST http://cart:8080/api/cart/dummy/666/1"
    sh "curl -s http://cart:8080/api/cart/dummy | grep 'Dummy Product'"
  }
}
