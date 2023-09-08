from airflow.models.dagrun import DagRun
from airflow.utils.state import DagRunState

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.email import EmailOperator


default_args = {
        'owner': 'sokhna',
        'depends_on_past': False,
        'email': ['samsydiouf14@gmail.com'],
        'email_on_failure': False,
        'email_on_success': False,
        'start_date': datetime (2023, 9, 9),
        #'retries': 1
        #'retry_delay': timedelta(minutes=5),
        }

dag_models = DAG('dbt_run_project_final', default_args=default_args, schedule='0 8 * * *')

dbt_project_dir = '/home/sokhna/dbt_project_final'
dbt_run_command = f'cd {dbt_project_dir} && dbt run'

 
email_task = EmailOperator(
    task_id ='email_task',
    to = 'samsydiouf14@gmail.com',
    subject = 'Alert airflow orchestration',
    html_content = '{{ task_instance.xcom_pull(key="recovered_data") }}',
    dag=dag_models
)
     
dag_runs = DagRun.find(dag_id='dbt_seeds')
last_run = dag_runs[-1]
print("last_run", last_run)
if last_run.state == DagRunState.SUCCESS:
    print('the dag seed was successfull!')
    print('Execution run task')
    # Tâche pour exécuter dbt run
    dbt_run_task = BashOperator (
        task_id='dbt_run_task',
        bash_command=dbt_run_command,
        dag=dag_models
        )
   
    # Définir les dépendances entre les tâches
    dbt_run_task >> email_task  
    
else:
    email_task