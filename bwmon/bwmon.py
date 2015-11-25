from flask import *
import os, sys, time

application = Flask(__name__)

image_path = '/var/www/apps/flask/bwmon/static/images/'
#image_list = os.listdir(image_path)
#gen_date = time.strftime('%d/%m/%y %H:%M:%S')

@application.route('/')
def index():
    image_list = os.listdir(image_path)
    return render_template('layout.html', images = image_list)

if __name__ == '__main__':
    application .run(host='192.168.1.204', debug = True)
