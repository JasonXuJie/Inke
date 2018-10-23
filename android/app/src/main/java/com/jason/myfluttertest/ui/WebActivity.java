package com.jason.myfluttertest.ui;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.ViewGroup;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.jason.myfluttertest.R;
import com.jason.myfluttertest.base.BaseActivity;
import com.just.agentweb.AgentWeb;

import butterknife.BindView;

/**
 * Created by jason on 2018/10/9.
 */

public class WebActivity extends BaseActivity {

    @BindView(R.id.toolBar_back)
    Toolbar toolBar_back;
    @BindView(R.id.tv_title)
    TextView tv_title;
    @BindView(R.id.layout_web_container)
    FrameLayout layout_web_container;
    private AgentWeb agentWeb;
    private String url;

    @Override
    public int getLayoutId() {
        return R.layout.activity_web;
    }

    @Override
    public void initViews() {
        setToolBarByBack(toolBar_back,"");
        Bundle bundle = getIntent().getExtras();
        if (bundle!=null){
            url = bundle.getString("url");
        }
        init(url);
    }

    @Override
    public void requestData() {

    }


    private void init(String url){
        agentWeb = AgentWeb.with(this)
                .setAgentWebParent(layout_web_container,new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT))
                .useDefaultIndicator(Color.BLUE)
                .setWebChromeClient(chromeClient)
                .createAgentWeb()
                .ready()
                .go(url);
    }



    private WebChromeClient chromeClient = new WebChromeClient(){
        @Override
        public void onReceivedTitle(WebView view, String title) {
            super.onReceivedTitle(view, title);
            tv_title.setText(title);
        }
    };


    @Override
    public void onBackPressed() {
        if(agentWeb.back()){
            agentWeb.back();
        }else {
            super.onBackPressed();
        }
    }

    @Override
    protected void onResume() {
        agentWeb.getWebLifeCycle().onResume();
        super.onResume();
    }


    @Override
    protected void onPause() {
        agentWeb.getWebLifeCycle().onPause();
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        agentWeb.getWebLifeCycle().onDestroy();
        super.onDestroy();
    }

}
