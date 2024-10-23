from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import CreateView, DetailView, FormView, ListView

from .forms import ArticleForm
from .models import Article


# Create your views here.
class ArticleListView(ListView):
    model = Article
    paginate_by = 10
    template_name = "articles/articles_list.html"
    context_object_name = "articles"
    ordering = ["-updated_time"]

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        page_obj = context["page_obj"]
        context["elided_page_range"] = (
            page_obj.paginator.get_elided_page_range(
                page_obj.number, on_each_side=2, on_ends=1
            )
        )
        return context


class ArticleCreateView(FormView):
    form_class = ArticleForm
    template_name = "articles/create.html"

    def form_valid(self, form):
        # 保存用户输入的内容到 session
        self.request.session["title"] = form.cleaned_data.get("title")
        self.request.session["content"] = form.cleaned_data.get("content")

        return render(
            self.request, "articles/create_confirm.html", {"form": form}
        )

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # 如果有 session 数据，加载用户之前输入的内容
        context["title"] = self.request.session.get("title", "")
        context["content"] = self.request.session.get("content", "")

        return context


class ArticleCreateConfirmView(CreateView):
    model = Article
    form_class = ArticleForm
    template_name = "articles/create_confirm.html"
    success_url = reverse_lazy("articles:list")

    def form_valid(self, form):
        # 提交表单数据到数据库
        response = super().form_valid(form)
        # 提交后清除 session 数据
        del self.request.session["title"]
        del self.request.session["content"]
        return response


def ArticleEdit(request):
    return render(request, "articles/edit.html")


def ArticleEditConfirm(request):
    return render(request, "articles/edit_confirm.html")


class ArticleDetailView(DetailView):
    model = Article
    template_name = "articles/detail.html"
    context_object_name = "article"


def ArticleDeleteConfirm(request):
    return render(request, "articles/delete_confirm.html")
