from PyPDF2 import PdfReader
with open("legislacao.txt", "r+", encoding='utf-8') as file:
    def read_pdf(file_path):
            with open(file_path, "rb") as file:
                pdf = PdfReader(file)
                text = ""
                num_pages = len(pdf.pages)
                for page_num in range(num_pages):
                    page = pdf.pages[page_num]
                    text += page.extract_text()
                return text      
    text=read_pdf("D:\estagio\Projeto.AI\GitHub\chatbot_app\sql\python\RDC_786_2023_.pdf")
    file.write(text)

    

