import os
os.system("sudo apt-get update")
os.system('sudo apt-get install openjdk-8-jre -y')
os.system('pip install http://h2o-release.s3.amazonaws.com/h2o/master/3901/Python/h2o-3.11.0.3901-py2.py3-none-any.whl')
os.system('pip install plotly')
os.system('pip install cufflinks')