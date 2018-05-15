# Run the CloudFormation template with AWS CLI

aws cloudformation create-stack \
  --stack-name elasticsearch-cluster-ubuntu \
  --template-body file://elasticsearch-template.yaml \
  --parameters \
    ParameterKey=Ami,ParameterValue=ami-6e1a0117 \
    ParameterKey=AsgMaxSize,ParameterValue=8 \
    ParameterKey=AsgMinSize,ParameterValue=2 \
    ParameterKey=EmailAlerts,ParameterValue=email_for_alerts@domain.com \
    ParameterKey=InstanceType,ParameterValue=m4.large \
    ParameterKey=KeyName,ParameterValue=YOUR_INSTANCE_KEY \
    ParameterKey=VpcId,ParameterValue=VPC_ID \
    ParameterKey=SubnetID1,ParameterValue=SUBNET_IN_VPC_ID_1 \
    ParameterKey=SubnetID2,ParameterValue=SUBNET_IN_VPC_ID_2 \
  --capabilities CAPABILITY_IAM
