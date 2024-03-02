package org.samsung.screenoffudfps;

import org.samsung.screenoffudfps.R;
import org.samsung.screenoffudfps.utils.FileUtils;
import org.samsung.screenoffudfps.utils.Tags;

import android.app.ActionBar;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

import androidx.preference.Preference;
import androidx.preference.Preference.OnPreferenceChangeListener;
import androidx.preference.PreferenceFragment;
import androidx.preference.PreferenceManager;
import androidx.preference.SeekBarPreference;
import androidx.preference.SwitchPreference;

public class SettingsFragment extends PreferenceFragment {

    private SharedPreferences mSharedPrefs;
    private SwitchPreference mScreenOffUdfpsPreference;

    @Override
    public void onCreatePreferences(Bundle savedInstanceState, String rootKey) {
        addPreferencesFromResource(R.xml.screenoffudfps_settings);

        mSharedPrefs = PreferenceManager.getDefaultSharedPreferences(getContext());

        mScreenOffUdfpsPreference = (SwitchPreference) findPreference(Tags.SCREEN_OFF_UDFPS_KEY);

        if (FileUtils.fileExists(Tags.SCREEN_OFF_UDFPS_NODE)) {
            mScreenOffUdfpsPreference.setEnabled(true);
            mScreenOffUdfpsPreference.setSummary(R.string.screen_off_udfps_summary);
        } else {
            mScreenOffUdfpsPreference.setEnabled(false);
            mScreenOffUdfpsPreference.setSummary(R.string.screen_off_udfps_not_supported);
        }

        mScreenOffUdfpsPreference.setOnPreferenceChangeListener((preference, newValue) -> {
            FileUtils.writeLine(Tags.SCREEN_OFF_UDFPS_NODE, (boolean)newValue?"fod_enable,1":"fod_enable,0");
            return true;
        });
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        final View view = LayoutInflater.from(getContext()).inflate(R.layout.screenoffudfps,
                container, false);
        ((ViewGroup) view).addView(super.onCreateView(inflater, container, savedInstanceState));
        return view;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
    }

    private boolean getScreenOffUdfps() {
        return mSharedPrefs.getBoolean(Tags.SCREEN_OFF_UDFPS_KEY, false);
    }
}
