package org.samsung.screenoffudfps;

import android.os.Bundle;

import com.android.settingslib.collapsingtoolbar.CollapsingToolbarBaseActivity;

public class SettingsActivity extends CollapsingToolbarBaseActivity {

    private static final String TAG_SCREENOFFUDFPS = "screenoffudfps";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getFragmentManager().beginTransaction().replace(
                com.android.settingslib.collapsingtoolbar.R.id.content_frame,
                new SettingsFragment(), TAG_SCREENOFFUDFPS).commit();
    }
}
