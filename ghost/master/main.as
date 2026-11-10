talk OnBoot {
	\![bind,onHand,,0]\![bind,onCup,,0]\![bind,onShoulder,,0]\![bind,onHead,,0]\![bind,onLeftHorn,,0]\![bind,onRightHorn,,0]\![bind,onBust,,0]\![bind,onMouth,,0]\s[0]
  そろそろ\w9とりを出すか……\w9\w9\w9{鳥をランダム配置()}
}


function 鳥をランダム配置 {
	local result = "\![lock,repaint]";
	result += "\![bind,onHand,,0]\![bind,onCup,,0]\![bind,onShoulder,,0]\![bind,onHead,,0]\![bind,onLeftHorn,,0]\![bind,onRightHorn,,0]\![bind,onBust,,0]\![bind,onMouth,,0]";

	local 位置temp = ["onHand","onCup","onShoulder","onHead","onLeftHorn","onRightHorn","onBust"];
	local 位置列 = [];
	while(位置temp.length > 0) {
		local idx = Random.GetIndex(0, 位置temp.length - 1);
		位置列.Add(位置temp[idx]);
		位置temp.Remove(idx);
	}

	local 羽数 = Random.Select([3, 4]);
	local onMouthあり = Random.GetIndex(0, 11) == 0;

	local 鳥pool = ["01","02","03","04"];
	if(onMouthあり) {
		鳥pool.Remove(3);
		result += "\![bind,onMouth,04,1]";
		羽数 = 羽数 - 1;
	}

	local 鳥列 = [];
	while(鳥pool.length > 0) {
		local idx = Random.GetIndex(0, 鳥pool.length - 1);
		鳥列.Add(鳥pool[idx]);
		鳥pool.Remove(idx);
	}

	for(local i = 0; i < 羽数; i++) {
		result += "\![bind,{位置列[i]},{鳥列[i]},1]";
	}

	result += "\![unlock,repaint]";
	return result;
}



talk OnMouseDoubleClick {
	>ランダムトーク
}

function OnAosoraLoad {
	TalkTimer.RandomTalk = ランダムトーク;
	TalkTimer.RandomTalkIntervalSeconds = 180;
}
