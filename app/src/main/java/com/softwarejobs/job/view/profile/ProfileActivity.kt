package com.softwarejobs.job.view.profile

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.google.android.material.chip.Chip
import com.google.firebase.auth.FirebaseAuth
import kotlinx.android.synthetic.main.activity_profile.*


class ProfileActivity : AppCompatActivity() {
    private val FRAGMENT = "skill_fragment"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(com.softwarejobs.job.R.layout.activity_profile)

        Glide.with(this)
            .load(FirebaseAuth.getInstance().currentUser!!.photoUrl)
            .apply(RequestOptions().circleCrop())
            .into(iv_profile_image)

        chip_add_skills.setOnClickListener {
            var fragment = SkillDialogFragment.create()
            fragment.show(supportFragmentManager, FRAGMENT)
            fragment.setSkillAddListener(object :
                SkillDialogFragment.SkillAddListener {
                override fun onSkillAddition(list: List<String>) {
                    list.forEach {
                        var chip = Chip(this@ProfileActivity)
                        chip.text = it
                        skills_cg.addView(chip)
                    }
                }
            })
        }

        iv_profile_image.setOnClickListener {
            var dialog = ImageChooserDialog.create()
            dialog.show(supportFragmentManager, "image_chooser")
        }
    }

    companion object {
        fun start(context: Context) {
            var intent = Intent(context, ProfileActivity::class.java)
            context.startActivity(intent)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == ImageChooserDialog.REQUEST_GALLERY_PHOTO) {
            var imageUri = data!!.data

        }
    }
}
