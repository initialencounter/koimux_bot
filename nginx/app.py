from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

# 创建 FastAPI 实例
app = FastAPI()

app.mount("/", StaticFiles(directory="./script"), name="static")
# 运行 FastAPI 应用
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, port=8080)

