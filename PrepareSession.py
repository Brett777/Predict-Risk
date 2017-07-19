import os
os.system("sudo apt-get update")
os.system('sudo apt-get install openjdk-8-jre -y')
os.system('pip install http://h2o-release.s3.amazonaws.com/h2o/master/3961/Python/h2o-3.13.0.3961-py2.py3-none-any.whl')
os.system('pip install plotly')
os.system('pip install cufflinks')