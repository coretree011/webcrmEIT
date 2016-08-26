package com.coretree.defaultconfig.azure;

import com.coretree.models.SmsData;
import com.coretree.models.UcMessage;

// CORETREE 모듈 호환용

public interface ITelStatusService  {
	void RequestToPbx(UcMessage msg);
	void SendSms(SmsData msg);
}
