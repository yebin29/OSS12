phonebook="phonebook.txt"

case ${2%%-*} in
  "02") region="서울" ;;
  "031") region="경기" ;;
  "032") region="인천" ;;
  "051") region="부산" ;;
  "053") region="대구" ;;
  "064") region="제주" ;;
  "010") region="개인" ;;
  *) region="해당하는 지역번호는 지원되지 않습니다." ;;
  
esac


  
if [ $# -ne 2 ]; then
  echo "전화번화와 이름을 입력하세요."
  exit 1
fi

name=$1
phone_number=$2

if ! [[ $phone_number =~ ^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$ ]]; then
  echo "전화번호 형식이 올바르지 않습니다."
  exit 1
fi

if [ ! -f $phonebook ]; then
  touch $phonebook
fi


if grep -q "^$name " $phonebook; then
  exist_phone=$(grep "^name" $phonebook | cut -d' ' -f2)
  if [ "$exist_phone" == "$phone_number" ]; then
    echo "이미 존재하는 번호입니다."
    exit 0
  fi
fi

echo "$name $phone_number $region" >> "$phonebook"
echo "새로운 전화번호가 추가 되었습니다."
sort -o "$phonebook" "$phonebook"
exit 0

