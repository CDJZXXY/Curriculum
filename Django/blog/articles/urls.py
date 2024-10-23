from django.urls import path

from . import views

app_name = "articles"
urlpatterns = [
    path("", views.ArticleListView.as_view(), name="list"),
    path("create/", views.ArticleCreateView.as_view(), name="create"),
    path(
        "create_confirm/",
        views.ArticleCreateConfirmView.as_view(),
        name="create_confirm",
    ),
    path("edit/", views.ArticleEdit),
    path("edit_confirm/", views.ArticleEditConfirm),
    path("<int:pk>/detail/", views.ArticleDetailView.as_view(), name="detail"),
    path("delete_confirm/", views.ArticleDeleteConfirm),
]
