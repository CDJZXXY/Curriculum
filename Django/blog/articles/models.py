from django.db import models


# Create your models here.
class Article(models.Model):
    title = models.CharField("タイトル", max_length=50)
    content = models.CharField("本文", max_length=10000)
    created_time = models.DateTimeField("作成日時", auto_now_add=True)
    updated_time = models.DateTimeField("更新日時", auto_now=True)

    def __str__(self):
        return self.title
