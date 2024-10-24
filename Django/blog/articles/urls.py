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
    path("<int:pk>/edit/", views.ArticleEditView.as_view(), name="edit"),
    path(
        "<int:pk>/edit_confirm/",
        views.ArticleEditConfirmView.as_view(),
        name="edit_confirm",
    ),
    path("<int:pk>/", views.ArticleDetailView.as_view(), name="detail"),
    path(
        "<int:pk>/delete_confirm/",
        views.ArticleDeleteConfirm,
        name="delete_confirm",
    ),
]
