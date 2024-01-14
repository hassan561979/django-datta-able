from django.core.management.base import BaseCommand
from concurrent.futures import ThreadPoolExecutor, as_completed
import time


class Command(BaseCommand):
    help = 'Run multiple long tasks in parallel'

    def handle(self, *args, **options):
        # Number of tasks to run in parallel
        num_tasks = 2

        # Using ThreadPoolExecutor to run tasks in parallel
        with ThreadPoolExecutor(max_workers=num_tasks) as executor:
            # Submit each task to the executor
            for i in range(num_tasks):
                future_to_task = {executor.submit(
                    self.long_running_task, i)}

            # Wait for all tasks to complete
            for future in as_completed(future_to_task):
                task_id = future_to_task[future]
                try:
                    # Retrieve the result of each task
                    result = future.result()
                    self.stdout.write(self.style.SUCCESS(
                        f"Task {task_id} result: {result}"))
                except Exception as e:
                    self.stderr.write(self.style.ERROR(
                        f"Task {task_id} failed with exception: {e}"))

    def long_running_task(self, task_id):
        while True:
            # Simulate a long-running task
            self.stdout.write(self.style.SUCCESS(f"Task {task_id} started"))
            if task_id == 1:
                time.sleep(1)
            else:
                time.sleep(5)

            self.stdout.write(self.style.SUCCESS(f"Task {task_id} completed"))
