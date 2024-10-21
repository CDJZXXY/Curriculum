FROM python:3.9

ENV PYTHONUNBUFFERED 1

RUN mkdir /code

WORKDIR /app

# 复制依赖文件
COPY requirements.txt .

# 安装依赖
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# 复制项目代码
COPY . .

# 启动命令
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
