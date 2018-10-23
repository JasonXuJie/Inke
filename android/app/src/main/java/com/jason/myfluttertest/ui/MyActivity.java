package com.jason.myfluttertest.ui;

import android.support.v7.widget.Toolbar;
import com.jason.myfluttertest.R;
import com.jason.myfluttertest.base.BaseActivity;
import butterknife.BindView;

/**
 * Created by jason on 2018/10/9.
 */

public class MyActivity extends BaseActivity {

    @BindView(R.id.toolBar_back)
    Toolbar toolBar_back;


    @Override
    public int getLayoutId() {
        return R.layout.activity_about_me;
    }

    @Override
    public void initViews() {
      setToolBarByBack(toolBar_back,"关于我");
    }

    @Override
    public void requestData() {

    }
}
