import os
os.system("sudo apt-get update")
os.system('sudo apt-get install openjdk-8-jre -y')
os.system('pip install http://s3.amazonaws.com/h2o-deepwater/public/nightly/latest/h2o-3.11.0-py2.py3-none-any.whl')
os.system('pip install plotly')
os.system('pip install cufflinks')