package com.softwarejobs.job.view.profile

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.view.children
import com.google.android.material.chip.Chip
import com.softwarejobs.job.R
import kotlinx.android.synthetic.main.fragment_skill.*

class SkillDialogFragment : DialogFragment() {
    lateinit var mSkillAddListener: SkillAddListener

    companion object {
        fun create(): SkillDialogFragment {
            return SkillDialogFragment()
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.DialogStyle)
    }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_skill, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        chip_add_skills.setOnClickListener {
            var chip = Chip(context)
            chip.text = til_skill_input.editText!!.text.toString()
            chip.isCloseIconVisible = true
            chip.setOnCloseIconClickListener {
                skill_cg.removeView(chip)
            }
            skill_cg.addView(chip)
            til_skill_input.editText!!.text.clear()
        }

        btn_cancel.setOnClickListener { dismiss() }
        btn_add.setOnClickListener {
            mSkillAddListener.onSkillAddition(skill_cg.children.toList().map { (it as Chip).text.toString() })
            dismiss()
        }
    }

    fun setSkillAddListener(listener: SkillAddListener) {
        mSkillAddListener = listener
    }

    interface SkillAddListener {
        fun onSkillAddition(list: List<String>)
    }
}