from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
default_args = {
        'owner': 'sokhna',
        'start_date': datetime (2023, 9, 9),
        'retries': 1
        }
dag = DAG('dbt_seeds_project_final', default_args=default_args, schedule='0 8 * * *')

dbt_project_dir = '/home/sokhna/dbt_project_final'
dbt_seed_command = f'cd {dbt_project_dir} && dbt seed'

# Tâche pour exécuter dbt seed
dbt_seed_task = BashOperator (
        task_id='dbt_seed_task',
        bash_command=dbt_seed_command,
        dag=dag
        )
# Définir les dépendances entre les tâches
dbt_seed_task
