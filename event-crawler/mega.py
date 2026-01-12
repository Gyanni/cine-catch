import asyncio
from playwright.async_api import async_playwright
import json
import time
from datetime import datetime

async def get_megabox_data(context, event_no, event_name):
    page = await context.new_page()
    # 메가박스 상세 페이지 주소
    target_url = f"https://www.megabox.co.kr/event/detail?eventNo={event_no}"
    
    inventory_data = []

    # [핵심] 앱/웹에서 재고를 불러올 때 사용하는 API 응답을 가로챔
    async def capture_api(response):
        # 재고 관련 API 주소 키워드 (실제 주소는 네트워크 탭 확인 필요)
        if "selectSpecialGiftStockList" in response.url or "stock" in response.url:
            try:
                data = await response.json()
                # 메가박스 JSON 구조에 맞춰 파싱 (예시 구조)
                stocks = data.get("list", [])
                for s in stocks:
                    inventory_data.append({
                        "theater": s.get("brchNm"), # 지점명
                        "status": s.get("restCnt")  # 잔여 수량 또는 상태
                    })
            except:
                pass

    page.on("response", capture_api)
    
    try:
        # 모바일 앱처럼 보이기 위해 User-Agent가 설정된 context 사용
        await page.goto(target_url, wait_until="networkidle")
        # API 응답이 올 때까지 잠시 대기
        await asyncio.sleep(2) 
        
        await page.close()
        return {
            "event_name": event_name,
            "items": inventory_data,
            "updated_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        }
    except:
        await page.close()
        return None

async def main():
    async with async_playwright() as p:
        # 앱처럼 보이도록 설정
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context(**p.devices['iPhone 13'])
        
        # 1. 먼저 이벤트 목록에서 번호와 제목을 가져오는 로직 (CGV와 유사)
        # ... (목록 수집 로직) ...
        
        # 예시 데이터로 테스트
        test_event = {"no": "16752", "name": "[아바타] TTT"} 
        result = await get_megabox_data(context, test_event['no'], test_event['name'])
        
        print(json.dumps(result, indent=4, ensure_ascii=False))
        await browser.close()

if __name__ == "__main__":
    asyncio.run(main())