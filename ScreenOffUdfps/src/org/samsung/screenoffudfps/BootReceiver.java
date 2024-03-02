/*
 * Copyright (c) 2021-2022 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.samsung.screenoffudfps;

import org.samsung.screenoffudfps.utils.FileUtils;
import org.samsung.screenoffudfps.utils.Tags;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.content.SharedPreferences;
import androidx.preference.PreferenceManager;

public class BootReceiver extends BroadcastReceiver {
    private static final boolean DEBUG = false;
    private static final String TAG = "ScreenOffUdfps";

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (DEBUG)
            Log.d(TAG, "Received boot completed intent");

        SharedPreferences sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context);

        boolean kScreenOffUdfps = sharedPrefs.getBoolean(Tags.SCREEN_OFF_UDFPS_KEY, false);
        FileUtils.writeLine(Tags.SCREEN_OFF_UDFPS_NODE, kScreenOffUdfps?"fod_enable,1":"fod_enable,0");
    }
}
