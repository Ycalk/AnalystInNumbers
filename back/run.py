import os
import subprocess
port = os.environ['PORT']

subprocess.run(["python", "back/manage.py", "create_super_user"])

subprocess.run(["python", "back/manage.py", "runserver", f"0.0.0.0:{port}"])