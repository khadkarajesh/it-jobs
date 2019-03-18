package com.softwarejobs.job

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import kotlinx.android.synthetic.main.activity_main.*

class HomeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        addFragment(HomeFragment.getInstance())
        home_navigation.setOnNavigationItemSelectedListener {
            when (it.itemId) {
                R.menu.home_menu -> {
                    addFragment(HomeFragment.getInstance())
                }
            }
            true
        }

    }

    private fun addFragment(fragment: Fragment) {
        supportFragmentManager.beginTransaction()
            .replace(R.id.container, fragment)
            .commit()
    }

    companion object {
        fun start(context: Context) {
            var intent = Intent(context, HomeActivity::class.java)
            context.startActivity(intent)
        }
    }
}
