from django.urls import path

from . import views

urlpatterns = [
    path("", views.ArticleListView.as_view(), name="articles-list"),
    path("create/", views.ArticleCreate),
    path("create_confirm/", views.ArticleCreateConfirm),
    path("edit/", views.ArticleEdit),
    path("deit_confirm/", views.ArticleEditConfirm),
    path("detail/", views.ArticleDetail),
    path("delete_confirm/", views.ArticleDeleteConfirm),
]
