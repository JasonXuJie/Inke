package com.jason.myfluttertest.base;

import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import android.view.View;
import android.widget.TextView;

import com.jason.myfluttertest.R;

import butterknife.ButterKnife;
import butterknife.Unbinder;

/**
 * Created by jason on 2018/10/9.
 */

public abstract class BaseActivity extends AppCompatActivity {


    private Unbinder unbinder;

    @Override
    protected final void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
        unbinder = ButterKnife.bind(this);
        initViews();
        requestData();
    }


    public abstract int getLayoutId();


    public abstract void initViews();


    public abstract void requestData();



    public void setToolBarByBack(Toolbar toolbar,String title){
        TextView tv_title = toolbar.findViewById(R.id.tv_title);
        if (tv_title!=null)tv_title.setText(title);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
    }




    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (unbinder!=null) unbinder.unbind();
    }
}
