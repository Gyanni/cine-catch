#!/bin/bash
set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Cine-Catch Frontend 배포 스크립트 ===${NC}"

# 환경 변수 확인
S3_BUCKET=${S3_BUCKET:-"cine-catch-frontend-prod"}
CLOUDFRONT_DISTRIBUTION_ID=${CLOUDFRONT_DISTRIBUTION_ID:-""}

if [ -z "$CLOUDFRONT_DISTRIBUTION_ID" ]; then
  echo -e "${RED}Error: CLOUDFRONT_DISTRIBUTION_ID 환경 변수가 설정되지 않았습니다.${NC}"
  echo "사용법: CLOUDFRONT_DISTRIBUTION_ID=XXXXX ./deploy.sh"
  exit 1
fi

# 1. 빌드
echo -e "${GREEN}[1/3] 프론트엔드 빌드 중...${NC}"
npm run build

# 2. S3 업로드
echo -e "${GREEN}[2/3] S3에 업로드 중...${NC}"
aws s3 sync build/ s3://$S3_BUCKET --delete

# 3. CloudFront 캐시 무효화
echo -e "${GREEN}[3/3] CloudFront 캐시 무효화 중...${NC}"
aws cloudfront create-invalidation \
  --distribution-id $CLOUDFRONT_DISTRIBUTION_ID \
  --paths "/*"

echo -e "${GREEN}=== 배포 완료! ===${NC}"
echo -e "URL: https://cine-catch.com"
