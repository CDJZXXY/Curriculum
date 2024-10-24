from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import (
    CreateView,
    DetailView,
    FormView,
    ListView,
    UpdateView,
)

from .forms import ArticleForm
from .models import Article


# Create your views here.
# / & /articles
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
        if "edit_title" in self.request.session:
            del self.request.session["edit_title"]
        if "edit_content" in self.request.session:
            del self.request.session["edit_content"]

        return context


# /articles/create
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


# /articles/create_confirm
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


# /articles/{id}/edit
class ArticleEditView(FormView):
    form_class = ArticleForm
    template_name = "articles/edit.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        form = Article.objects.get(id=self.kwargs["pk"])
        context["id"] = form.id
        # 如果有 session 数据，加载用户之前输入的内容
        context["title"] = self.request.session.get("edit_title", form.title)
        context["content"] = self.request.session.get(
            "edit_content", form.content
        )
        return context

    def form_valid(self, form):
        """将编辑后的数据保存到 session 并跳转到确认页面"""
        self.request.session["edit_title"] = form.cleaned_data.get("title")
        self.request.session["edit_content"] = form.cleaned_data.get("content")
        # print(f"打印测试！！！{self.kwargs['pk']}")
        return render(
            self.request,
            "articles/edit_confirm.html",
            {"form": form, "id": self.kwargs["pk"]},
        )


# /articles/{id}/edit_confirm
class ArticleEditConfirmView(UpdateView):
    model = Article
    form_class = ArticleForm
    template_name = "articles/edit_confirm.html"
    success_url = reverse_lazy("articles:list")

    def form_valid(self, form):
        # 提交表单数据到数据库
        response = super().form_valid(form)
        # 提交后清除 session 数据
        del self.request.session["edit_title"]
        del self.request.session["edit_content"]
        return response


# /articles/{id}/
class ArticleDetailView(DetailView):
    model = Article
    template_name = "articles/detail.html"
    context_object_name = "article"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if "edit_title" in self.request.session:
            del self.request.session["edit_title"]
        if "edit_content" in self.request.session:
            del self.request.session["edit_content"]

        return context


# /articles/{id}/delete_confirm
def ArticleDeleteConfirm(request):
    return render(request, "articles/delete_confirm.html")
