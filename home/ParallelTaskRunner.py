from concurrent.futures import ThreadPoolExecutor, wait
import time


class ParallelTaskRunner:
    def __init__(self, num_tasks):
        self.num_tasks = num_tasks

    def run_tasks(self):
        # Using ThreadPoolExecutor to run tasks in parallel
        with ThreadPoolExecutor(max_workers=self.num_tasks) as executor:
            # Submit each task to the executor
            futures = [executor.submit(self.long_running_task, i)
                       for i in range(self.num_tasks)]

            # Wait for all tasks to complete
            wait(futures)

            # Retrieve the results (optional)
            results = [future.result() for future in futures]
            return results

    def long_running_task(self, task_id):
        # Simulate a long-running task
        print(f"Task {task_id} started")
        if (task_id == 1):
            time.sleep(1)
        else:
            time.sleep(5)
        print(f"Task {task_id} completed")


# Example usage
if __name__ == "__main__":
    num_tasks = 3
    task_runner = ParallelTaskRunner(num_tasks)
    results = task_runner.run_tasks()
    print("All tasks completed.")
