from django.shortcuts import render
from django.views.generic.list import ListView

from .models import Article


# Create your views here.
class ArticleListView(ListView):
    model = Article
    paginate_by = 5
    template_name = "articles/articles_list.html"
    context_object_name = "articles"


def ArticleCreate(request):
    return render(request, "articles/create.html")


def ArticleCreateConfirm(request):
    return render(request, "articles/create_confirm.html")


def ArticleEdit(request):
    return render(request, "articles/edit.html")


def ArticleEditConfirm(request):
    return render(request, "articles/edit_confirm.html")


def ArticleDetail(request):
    return render(request, "articles/detail.html")


def ArticleDeleteConfirm(request):
    return render(request, "articles/delete_confirm.html")
