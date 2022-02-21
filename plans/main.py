from locust import HttpUser, task


class QuickstartUser(HttpUser):

    @task
    def get_segmentation(self):
        self.client.get("http://google.com")
