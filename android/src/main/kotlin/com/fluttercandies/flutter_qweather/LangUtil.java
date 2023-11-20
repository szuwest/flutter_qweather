package com.fluttercandies.flutter_qweather;

import com.qweather.sdk.bean.base.Lang;

import java.util.HashMap;

/**
 * 2023 android
 * Created by West 0n 2023/11/20
 */
public class LangUtil {
    public static Lang getLang(Object arguments) {
        if (arguments instanceof String) {
            return Lang.ZH_HANS;
        } else if (arguments instanceof HashMap) {
            HashMap<String, Object> param = (HashMap<String, Object>) arguments;
            String lang = (String) param.get("lang");
            if (lang == null) {
                return Lang.ZH_HANS;
            }
            try {
                return Lang.valueOf(lang.toUpperCase());
            } catch (Exception e) {
                return Lang.ZH_HANS;
            }

        }
        return Lang.ZH_HANS;
    }
}
